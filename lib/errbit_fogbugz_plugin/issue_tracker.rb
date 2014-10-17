require 'fogbugz'

module ErrbitFogbugzPlugin
  class IssueTracker < ErrbitPlugin::IssueTracker
    LABEL = 'fogbugz'

    NOTE = ''

    FIELDS = [
      [:project_id, {
        :label       => "Area Name"
      }],
      [:account, {
        :label       => "FogBugz URL",
        :placeholder => "abc from https://abc.fogbugz.com/"
      }],
      [:username, {
        :placeholder => "Username/Email for your account"
      }],
      [:password, {
        :placeholder => "Password for your account"
      }]
    ]


    def self.label
      LABEL
    end

    def self.note
      NOTE
    end

    def self.fields
      FIELDS
    end

    def self.body_template
      @body_template ||= ERB.new(File.read(
        File.join(
          ErrbitFogbugzPlugin.root, 'views', 'fogbugz_issues_body.txt.erb'
        )
      ))
    end

    def url
      sprintf('https://%s.fogbugz.com', params['account'])
    end

    def configured?
      errors.empty?
    end

    def comments_allowed?; false; end

    def errors
      errors = []
      if self.class.fields.detect {|f| params[f[0].to_s].blank? }
        errors << [:base, 'You must specify your FogBugz Area Name, FogBugz URL, Username, and Password']
      end
      errors
    end

    def client
      fogbugz = Fogbugz::Interface.new(
        :email => params['username'],
        :password => params['password'],
        :uri => url
      )
      fogbugz.authenticate
      fogbugz
    end

    def create_issue(problem, reported_by = nil)
      issue = {
        'sTitle' => "[#{ problem.environment }][#{ problem.where }] #{problem.message.to_s.truncate(100)}",
        'sArea' => params['project_id'],
        'sEvent' => self.class.body_template.result(binding),
        'sTags' => ['errbit'].join(','),
        'cols' => ['ixBug'].join(',')
      }

      fb_resp = client.command(:new, issue)
      problem.update_attributes(
        :issue_link => sprintf('%s/default.asp?%s', url, fb_resp['case']['ixBug']),
        :issue_type => self.class.label
      )
    end
  end
end
