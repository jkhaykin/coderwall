class Team::SearchWrapper
  attr_reader :item

  def initialize(item)
    @item = item.is_a?(Team) ? item.to_public_hash : item
  end

  def about
    item[:about]
  end

  def updated_at
    item[:updated_at]
  end

  def rank
    item[:rank]
  end

  def to_key
    item.try(:to_key) || BSON::ObjectId(item[:id])
  end

  def name
    item[:name]
  end

  def class
    Team
  end

  def score
    item[:score]
  end

  def slug
    item[:slug]
  end

  def avatar_url
    item[:avatar]
  end

  def thumbnail_url
    User::BLANK_PROFILE_URL
  end

  def team_members
    Array(item[:team_members])
  end

  def top_three_team_members
    team_members.first(3)
  end

  def top_two_team_members
    team_members.first(2)
  end

  def hiring?
    item[:hiring]
  end

  def size
    item[:size]
  end

  def id
    item[:id]
  end

  def locations_message
    Array(item[:locations]).join(", ")
  end
end
