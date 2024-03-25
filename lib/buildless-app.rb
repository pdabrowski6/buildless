# frozen_string_literal: true

require 'rest-client'
require 'json'
require 'fileutils'
require 'thor'

require 'buildless/cli/fetch_template'
require 'buildless/cli/processor'
require 'buildless/version'
require 'buildless/rails_app'

module Buildless
  RailsNotInstalled = Class.new(StandardError)

  class << self
    def apply(template)
      verify_rails_installation
      generate_project(template)
      generate_files(template['files'])
      run_bundle_commands(template['bundle_commands'])
      inject_code(template['inject_code'])

      puts 'Time for coding! 🚀'
    end

    private

    def verify_rails_installation
      return if system("gem list ^rails$ --version #{Buildless::RAILS_VERSION} -i")

      raise RailsNotInstalled, "Please install Rails #{Buildless::RAILS_VERSION} and retry"
    end

    def generate_project(template)
      system template['installation_command']

      Dir.chdir(template['name'])
    end

    def generate_files(files)
      files.each do |file|
        puts "-> \e[1;32;49mCreate\e[0m #{file['file_path']}"
        file_path = File.join(Dir.pwd, file['file_path'])
        FileUtils.mkdir_p(File.dirname(file_path))
        File.write(file_path, file['content'])
      end
    end

    def run_bundle_commands(commands)
      commands.each do |command|
        system command
      end
    end

    def inject_code(injections)
      return if injections.nil? || injections.empty?

      thor_app = ::Buildless::RailsApp.new

      injections.each do |injection|
        thor_app.inject_into_class(injection['file_path'], injection['class_name'], injection['content'])
      end
    end
  end
end
