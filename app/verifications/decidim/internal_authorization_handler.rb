# frozen_string_literal: true

module Decidim
  class InternalAuthorizationHandler < AuthorizationHandler
    attribute :reference, String
    attribute :email, String
    
    validates :reference, presence: true
    validates :email, presence: true

    def metadata
      super.merge(reference: reference, email: email)
    end

    def unique_id
      "#{email}#{reference}"
    end
  end
end
