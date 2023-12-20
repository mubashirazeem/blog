ActiveAdmin.register User do
  permit_params :email, :user_name, :password, :password_confirmation, role_ids: [] # Use role_ids for the association

  form do |f|
    f.inputs 'User Details' do
      f.input :email
      f.input :user_name
      f.input :password
      f.input :password_confirmation
      f.input :roles, as: :check_boxes, collection: Role.all
    end
    f.actions
  end

  filter :email
  filter :user_name
  filter :roles_id_in, as: :select, collection: Role.all.pluck(:name), label: 'Roles'

  index do
    selectable_column
    column :id
    column :email
    column :user_name
    column :roles do |user|
      user.roles.map(&:name).join(', ')
    end
    actions
  end
end
