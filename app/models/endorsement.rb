class Endorsement < ActiveRecord::Base
  include ResqueSupport::Basic

  belongs_to :endorsed, class_name: User.name, foreign_key: :endorsed_user_id, counter_cache: :endorsements_count, touch: true
  belongs_to :endorser, class_name: User.name, foreign_key: :endorsing_user_id
  belongs_to :skill, counter_cache: :endorsements_count, touch: :updated_at

  validates_presence_of :skill_id
  validates_presence_of :endorser
  validates_presence_of :endorsed
  after_create :generate_event

  def generate_event
    enqueue(GenerateEvent, self.event_type, Audience.user(self.endorsed.id), self.to_event_hash, 1.minute)
  end

  def to_event_hash
    { endorsement: { endorsed: self.endorsed.name, endorser: self.endorser.name, skill: self.skill.name },
      user:        { username: self.endorser.username } }
  end

  def event_type
    :endorsement
  end
end

# == Schema Information
#
# Table name: endorsements
#
#  id                :integer          not null, primary key
#  endorsed_user_id  :integer
#  endorsing_user_id :integer
#  specialty         :string(255)
#  created_at        :datetime
#  updated_at        :datetime
#  skill_id          :integer
#
# Indexes
#
#  index_endorsements_on_endorsed_user_id   (endorsed_user_id)
#  index_endorsements_on_endorsing_user_id  (endorsing_user_id)
#  only_unique_endorsements                 (endorsed_user_id,endorsing_user_id,specialty) UNIQUE
#
