# frozen_string_literal: true

Decidim::Verifications.register_workflow(:internal_authorization_handler) do |auth|
  auth.form = 'Decidim::InternalAuthorizationHandler'
end
