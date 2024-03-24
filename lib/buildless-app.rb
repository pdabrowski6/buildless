# frozen_string_literal: true

require 'rest-client'
require 'json'
require 'fileutils'

require 'buildless/cli/fetch_template'
require 'buildless/cli/processor'
require 'buildless/version'

module Buildless
  RailsNotInstalled = Class.new(StandardError)

  class << self
    def apply(template)
      verify_rails_installation
      generate_project(template)
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
  end
end
