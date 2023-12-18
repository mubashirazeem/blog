ActiveAdmin.register Blog do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  # permit_params :title, :description, :user_id
  #
  # or
  #
  # permit_params do
  #   permitted = [:title, :description, :user_id]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  
 permit_params :title, :description, :user_id

  form do |f|
    f.inputs 'Blog Details' do
      f.input :title
      f.input :description
      f.input :user_id
    end
    f.actions
  end

  filter :title
  filter :user_email_cont, as: :select, collection: User.all.map { |user| [user.email, user.id] }, label: 'User'

  index do
    selectable_column
    column :id
    column :title
    column :description
    column :user_id
    column :created_at
    column :updated_at
    actions
  end
end
