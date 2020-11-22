DOWNLOADS_DIR = '~/Downloads'
PICTURES_DIR = '~/Pictures'

Maid.rules do
  rule 'Prune old downloads' do
    dir("#{DOWNLOADS_DIR}/*").each do |file|
      if 1.week.since?(accessed_at(file)) && !file.include?('keep')
        trash(file)
      end
    end
  end

  rule 'Delete old screenshots' do
    SCREENSHOT_DATE_REGEX = %r{
      Screenshot(\sfrom\s|_)
      (?<date>\d{4}-\d{2}-\d{2})
      (\s|_)
      (?<time>\d{2}-\d{2}-\d{2})
    }x

    dir("#{PICTURES_DIR}/Screenshot*").each do |file|
      filename_timestamp = file.match(SCREENSHOT_DATE_REGEX)
      screenshot_at = DateTime.strptime(
        "#{filename_timestamp[:date]} #{filename_timestamp[:time]}",
        '%Y-%m-%d %H-%M-%S'
      )

      if 1.week.since?(screenshot_at.to_time)
        trash(file)
      end
    end
  end

  rule 'Delete old VLC snaps' do
    VLC_SNAP_REGEX = %r{
      vlcsnap-
      (?<date>\d{4}-\d{2}-\d{2})
      -
      (?<time>\d{2}h\d{2}m\d{2}s)
    }x

    dir("#{PICTURES_DIR}/vlcsnap-*").each do |file|
      filename_timestamp = file.match(VLC_SNAP_REGEX)
      screenshot_at = DateTime.strptime(
        "#{filename_timestamp[:date]} #{filename_timestamp[:time]}",
        '%Y-%m-%d %Hh%Mm%Ss'
      )

      if 1.week.since?(screenshot_at.to_time)
        trash(file)
      end
    end
  end

  rule 'Empty trash' do
    dir('~/.local/share/Trash/files/*').each do |file|
      if 8.weeks.since?(accessed_at(file))
        remove(file)
      end
    end
  end
end
