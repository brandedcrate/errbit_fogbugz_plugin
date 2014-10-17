require 'errbit_fogbugz_plugin/version'
require 'errbit_fogbugz_plugin/issue_tracker'
require 'errbit_fogbugz_plugin/rails'

module ErrbitFogbugzPlugin
  def self.root
    File.expand_path '../..', __FILE__
  end
end

ErrbitPlugin::Registry.add_issue_tracker(ErrbitFogbugzPlugin::IssueTracker)
