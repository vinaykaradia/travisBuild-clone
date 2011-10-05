module Travis
  module Build
    module Scm
      class Git
        attr_reader :shell

        def initialize(shell)
          @shell = shell
        end

        def fetch(source, hash, target)
          clone(source, target)
          chdir(target)
          checkout(hash)
        end

        protected

          def clone(source, target)
            shell.export('GIT_ASKPASS', 'echo', :echo => false) # this makes git interactive auth fail
            shell.execute("git clone --depth=100 --quiet #{source} #{target}")
          end

          def chdir(target)
            shell.chdir(target)
          end

          def checkout(hash)
            shell.execute("git checkout -qf #{hash}")
          end
      end
    end
  end
end