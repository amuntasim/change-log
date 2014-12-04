module ChangeLog
  module Generators
    module Utils
      module InstanceMethods
        def say_custom(tag, text); say "\033[1m\033[36m" + tag.to_s.rjust(10) + "\033[0m" + " #{text}" end
        def ask_wizard(question)
          ask "\033[1m\033[30m\033[46m" + "prompt".rjust(10) + "\033[0m\033[36m" + " #{question}\033[0m"
        end
        def multiple_choice(question, choices)
          say_custom('question', question)
          values = {}
          choices.each_with_index do |choice,i|
            values[(i + 1).to_s] = choice[1]
            say_custom (i + 1).to_s + '.', choice[0]
          end
          answer = ask_wizard("Enter your selection:") while !values.keys.include?(answer)
          values[answer]
        end
        def display(output, color = :green)
          say("           -  #{output}", color)
        end

        def ask_for(wording, default_value = nil, override_if_present_value = nil)
          override_if_present_value.present? ?
            display("Using [#{override_if_present_value}] for question '#{wording}'") && override_if_present_value :
            ask("           ?  #{wording} Press <enter> for [#{default_value}] >", :yellow).presence || default_value
        end

        def ask_boolean(wording, default_value = nil)
          value = ask_for(wording, 'Y')
          value = (value == 'Y')
        end
      end

      module ClassMethods
        def next_migration_number(dirname)
          if ActiveRecord::Base.timestamped_migrations
            migration_number = Time.now.utc.strftime("%Y%m%d%H%M%S").to_i
            migration_number += 1
            migration_number.to_s
          else
            "%.3d" % (current_migration_number(dirname) + 1)
          end
        end
      end
    end
  end
end

