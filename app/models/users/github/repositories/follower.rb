# == Schema Information
#
# Table name: users_github_repositories_followers
#
#  repository_id :integer          not null
#  profile_id    :integer          not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class Users::Github::Repositories::Follower < ActiveRecord::Base
  belongs_to :profile, class_name: 'Users::Github::Profile'
  belongs_to :repository, :class_name => 'Users::Github::Repository'
end
