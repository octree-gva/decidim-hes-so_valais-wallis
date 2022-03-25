# frozen_string_literal: true

require 'decidim/faker/localized'
require 'decidim/faker/internet'

raise 'Already seeded' unless Decidim::Organization.count.zero?

organization = Decidim::Organization.first || Decidim::Organization.create!(
  name: 'Plateforme citoyenne du Valais',
  host: 'localhost',
  description: Decidim::Faker::Localized.wrapped('<p>', '</p>') do
    Decidim::Faker::Localized.sentence(word_count: 15)
  end,
  default_locale: Decidim.default_locale,
  available_locales: Decidim.available_locales,
  reference_prefix: 'HEVS',
  available_authorizations: ["csv_census", "internal_authorization_handler"],
  users_registration_mode: :enabled,
  tos_version: Time.current,
  badges_enabled: true,
  user_groups_enabled: true,
  send_welcome_notification: true,
  file_upload_settings: Decidim::OrganizationSettings.default(:upload),
  colors: {
    'alert' => '#ec5840',
    'primary' => '#0076b3',
    'success' => '#57d685',
    'warning' => '#ffae00',
    'highlight' => '#be6400',
    'secondary' => '#91c9f1',
    'highlight-alternative' => '#ff5731'
  }
)

Decidim::User.create!(
  email: 'admin@hevs.ch',
  name: Faker::Name.name,
  nickname: Faker::Twitter.unique.screen_name,
  password: 'changeme01',
  password_confirmation: 'changeme01',
  organization: organization,
  confirmed_at: Time.current,
  locale: I18n.default_locale,
  admin: true,
  tos_agreement: true,
  accepted_tos_version: organization.tos_version,
  admin_terms_accepted_at: Time.current
)

Decidim::System::Admin.create!(
  email: 'sysadmin@hevs.ch',
  password: 'changeme01',
  password_confirmation: 'changeme01'
)

Decidim::System::CreateDefaultPages.call(organization)
Decidim::System::PopulateHelp.call(organization)
Decidim::System::CreateDefaultContentBlocks.call(organization)

# Give some feedback of seeding operation
puts ""
puts "Organization created? #{Decidim::Organization.count.positive? ? '✅' : 'X'}"
puts ""
puts "Admin: #{Decidim::User.where(admin: true).pluck(:email).join(',')}"
puts "Sysadmin: #{Decidim::System::Admin.pluck(:email).join(',')}"
puts ""
puts "Help page? #{Decidim::StaticPage.where(slug: 'help').count.positive? ? '✅' : 'X'}"
puts "Homepage? #{Decidim::ContentBlock.count.positive? ? '✅' : 'X'}"
puts "Terms and Conditions? #{Decidim::StaticPage.where(slug: "terms-and-conditions").count.positive? ? '✅' : 'X'}"
