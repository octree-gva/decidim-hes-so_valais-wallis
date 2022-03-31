# frozen_string_literal: true

module Decidim
  class InternalAuthorizationHandler < AuthorizationHandler
    attribute :email, String

    def metadata
      super.merge(email: email)
    end

    def unique_id
      nil
    end
  end
end
