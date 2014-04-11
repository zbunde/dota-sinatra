Sequel.migration do
  up do
    create_table(:heroes) do
      primary_key :id
      String :name
      String :description
      String :hero_type
      String :image
    end
  end

  down do
    drop_table(:heroes)
  end
end
