
# rake  change_log:update_log['path_to/repo']
namespace :change_log do

  desc "Copying settings, models etc."
  task :setup => :environment do
    system 'rails g change_log:install'
  end

  desc "parse release notes and put into db"
  task :update_log , [:repo_path] => :environment do |t, args|
    repo_path = args.repo_path || Rails.root
    repo = Rugged::Repository.new("#{repo_path}/.git/")
    walker = Rugged::Walker.new(repo)
    walker.push(repo.head.target_id)
    walker.sorting(Rugged::SORT_DATE) # optional
    last_release = base_model.last_release
    if last_release
      records = walker.select { |c| c.time > last_release.time && c.message =~ /#{ChangeLog.config.commit_prefix}/ }
    else
      records = walker.select { |c| c.message =~ /#{ChangeLog.config.commit_prefix}/ }
    end
    records.each do |record|
      parse_ans_store_commit_message(record, last_release)
    end
  end

  def parse_ans_store_commit_message(record, last_release)
#     messages = <<-eos
# ###
# ##api
#
#     * Unordered list can use asterisks
#     * Unordered list can use
#
# ##core
#
#     * Unordered list can use +
#     * Unordered list can use asterisks
#     eos
#     lines = messages.lines

    lines = record.message.lines
    version = version_number(lines.shift)
    o_tag = []
    formatted_message = []
    lines.each do |line|
      if tag = parse_tag(line)
        o_tag << tag
        formatted_message << "<p>#{tag}</p>"
      else
        formatted_message << line
      end
    end
    base_model.create(version: version, author: record.author, message: formatted_message.join(''), time: record.time, tags: o_tag.join(','))
#base_model.create(version: version, author: 'record.author', message: formatted_message.join(''), time: 'record.time', tags: o_tag.join(','))
  end

  def parse_tag(line)
    line.gsub(ChangeLog.config.tag_prefix, '').strip if line =~ /#{ChangeLog.config.tag_prefix}/
  end

  def version_number(line)
    t_release = line.gsub(ChangeLog.config.commit_prefix, '').strip
    n = t_release.split('.').join('').to_i
    if n > 0
      t_release
    elsif  last_release = base_model.last_release
      t_release_a = last_release.version.split('.')
      last_number = t_release_a.pop
      t_release_a << last_number.to_i + 1
      t_release_a.join('.')
    else
      '0.0.1'
    end
  end

  def base_model
    if ChangeLog.config.orm == 'activerecord'
      ChangeLog::ActiverecordModel
    else
      ChangeLog::MongoidModel
    end
  end
end
