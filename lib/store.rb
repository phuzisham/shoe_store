class Store < ActiveRecord::Base
  has_and_belongs_to_many(:brands)
  validates(:title, {:presence => true, :length => {:maximum => 100}})
  validates(:title, uniqueness: { case_sensitive: false })
  before_save(:upcase_title)

  private

  def upcase_title
    array = self.title.split
    array.each do |t|
      t.capitalize!
    end
    self.title = array.join(' ')
  end
end
