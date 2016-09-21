class Qit < ActiveRecord::Base
  validates :borrower_id, presence: true, uniqueness: true
  validates :borrower, presence: true
  validates :item, presence: true
  validates :item_id, presence: true, uniqueness: true
  validates :borrowed_on, presence: true
  validates :item_status, presence: true
  validates :incharge, presence: true
  validates :issue, presence: true
  self.per_page = 6
  def self.search(search)
    where("item LIKE ?", "%#{search.upcase}%")
  end

end
