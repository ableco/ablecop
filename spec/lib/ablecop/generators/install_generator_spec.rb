require "generator_spec"
require "ablecop/generators/install_generator"

describe Ablecop::InstallGenerator, type: :generator do
  destination File.expand_path("../../../../tmp", File.dirname(__FILE__))

  context "file generation" do
    before(:all) do
      prepare_destination
      run_generator
    end

    it "copies the default configuration file for Rubocop" do
      assert_file ".rubocop.yml"
    end

    it "copies the default configuration file for Fasterer" do
      assert_file ".fasterer.yml"
    end

    it "copies the default configuration file for scss-lint" do
      assert_file ".scss-lint.yml"
    end

    it "copies the default configuration file for Rails Best Practices" do
      assert_file "config/rails_best_practices.yml"
    end
  end

  context "adding files to .gitignore" do
    let(:gitignore_file) { File.expand_path(".gitignore", destination_root) }

    context "with existing .gitignore" do
      before(:all) do
        prepare_destination
        File.open("#{destination_root}/.gitignore", "w") { |f| f.write("test1\ntest2\n") }
        run_generator
      end

      it "adds '.rubocop.yml' to the project's .gitignore" do
        expect(File.readlines(gitignore_file)).to include(%r{^/.rubocop.yml$})
      end

      it "adds '.fasterer.yml' to the project's .gitignore" do
        expect(File.readlines(gitignore_file)).to include(%r{^/.fasterer.yml$})
      end

      it "adds '.scss-lint.yml' to the project's .gitignore" do
        expect(File.readlines(gitignore_file)).to include(%r{^/.scss-lint.yml$})
      end

      it "adds 'config/rails_best_practices.yml' to the project's .gitignore" do
        expect(File.readlines(gitignore_file)).to include(%r{^/config/rails_best_practices.yml$})
      end
    end

    context "without existing .gitignore" do
      before(:all) do
        prepare_destination
      end

      it "creates a .gitignore file if it doesn't exist" do
        expect(File.exist?(gitignore_file)).to eq(false)
        run_generator
        expect(File.exist?(gitignore_file)).to eq(true)
      end
    end
  end

  context "raising errors if file is not copied" do
    before(:all) do
      prepare_destination
    end

    it "raises a ConfigFileError if the configuration file was not copied"
  end

  context "checking existing files in .gitignore" do
    let(:gitignore_file) { File.expand_path(".gitignore", destination_root) }

    before(:all) do
      prepare_destination
      File.open("#{destination_root}/.gitignore", "w") { |f| f.write(".fasterer.yml\n.rubocop.yml\n.scss-lint.yml\nconfig\/rails_best_practices.yml\n") }
      run_generator
    end

    it "updates '.rubocop.yml' to '/.rubocop.yml' in the project's .gitignore if it exists" do
      expect(File.readlines(gitignore_file)).to_not include(/^.rubocop.yml$/)
      expect(File.readlines(gitignore_file)).to include(%r{^/.rubocop.yml$})
    end

    it "adds '.fasterer.yml' to '/.fasterer.yml' in the project's .gitignore if it exists" do
      expect(File.readlines(gitignore_file)).to_not include(/^.fasterer.yml$/)
      expect(File.readlines(gitignore_file)).to include(%r{^/.fasterer.yml$})
    end

    it "adds '.scss-lint.yml' to './scss-lint.yml' in the project's .gitignore if it exists" do
      expect(File.readlines(gitignore_file)).to_not include(/^.scss-lint.yml$/)
      expect(File.readlines(gitignore_file)).to include(%r{^/.scss-lint.yml$})
    end

    it "adds 'config/rails_best_practices.yml' to '/config/rails_best_practices.yml' in the project's .gitignore if it exists" do
      expect(File.readlines(gitignore_file)).to_not include(%r{^config/rails_best_practices.yml$})
      expect(File.readlines(gitignore_file)).to include(%r{^/config/rails_best_practices.yml$})
    end
  end

  context "overriding default configuration files" do
    before(:all) do
      prepare_destination

      override_dir = File.expand_path("config/ablecop", destination_root)
      FileUtils.mkdir_p(override_dir)
      File.open("#{override_dir}/.rubocop.yml", "w") { |f| f.write("additional_rubocop_config: config") }
      File.open("#{override_dir}/.fasterer.yml", "w") { |f| f.write("additional_fasterer_config: config") }
      File.open("#{override_dir}/.scss-lint.yml", "w") { |f| f.write("additional_scss_lint_config: config") }
      File.open("#{override_dir}/rails_best_practices.yml", "w") { |f| f.write("additional_best_practice: config") }

      run_generator
    end

    it "updates the configuration file for Rubocop if an override file exists" do
      assert_file ".rubocop.yml", /additional_rubocop_config: config/
    end

    it "updates the configuration file for Fasterer if an override file exists" do
      assert_file ".fasterer.yml", /additional_fasterer_config: config/
    end

    it "updates the configuration file for scss-lint if an override file exists" do
      assert_file ".scss-lint.yml", /additional_scss_lint_config: config/
    end

    it "updates the configuration file for scss-lint if an override file exists" do
      assert_file "config/rails_best_practices.yml", /additional_best_practice: config/
    end
  end
end
