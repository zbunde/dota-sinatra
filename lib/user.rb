class User
  def initialize(db)
    @db = db[:users]
  end

  def index
    @db.all
  end

  def create(user)
    @db.insert(user)
  end

  def find(id)
    @db[:id => id]
  end

  def update(id, attributes)
    @db.where(:id => id).update(attributes)
  end

  def delete(id)
    @db.where(:id => id).delete
  end

end