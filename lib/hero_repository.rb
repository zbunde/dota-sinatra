class HeroRepository
  def initialize(db)
    @db = db[:heroes]
  end
  def index
    @db.all
  end
  def create(hero)
    @db.insert(hero)
  end
  def show(id)
    @db[:id => id]
  end
  def find_name(id)
    @db[:id => id][:name]
  end
  def all_names
    @db.select(:name).to_a
  end
  def update(id, attributes)
    @db.where(:id => id).update(attributes)
  end
  def delete(id)
    @db.where(:id => id).delete
  end
end