require 'net/ldap'

module OmniAuth
  module Strategies
    class Webiso < Env
      def initialize(app, options = {})
        options[:name] ||= :webiso
        super(app, options)
      end

    protected

      def auth_hash
        @extra_info = ldap_user_info
        @user_info = {
          'first_name' => @extra_info['givenname'],
          'last_name'  => @extra_info['sn']
        }
        OmniAuth::Utils.deep_merge(super, {
          'user_info' => @user_info,
          'extra' => { 'ldap_results' => @extra_info }
        })
      end

    private

      def ldap_user_info
        options = {
          :base => 'ou=Person, dc=cmu, dc=edu',
          :attributes => [
            'givenName', 'sn', 'nickname', 'eduPersonSchoolCollegeName',
            'cmuStudentClass', 'mail', 'cmuPreferredMail'
          ],
          :filter => Net::LDAP::Filter.eq('cmuPersonPrincipalName', @uid),
          :return_result => false,
          :size => 1
        }

        results = {}

        Net::LDAP.open(:host => 'ldap.andrew.cmu.edu', :port => 389) do |ldap|
          ldap.search(options) do |entry|
            entry.each do |attribute, values|
              results[attribute.to_s] = values.first
            end
          end
        end

        results
      rescue Net::LDAP::LdapError
        return {}
      end

    end
  end
end
