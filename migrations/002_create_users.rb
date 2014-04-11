Sequel.migration do
  up do
    create_table(:users) do
      primary_key :id
      String :username
      String :first_name
      String :last_name
      String :email
    end
  end

  down do
    drop_table(:users)
  end
end
