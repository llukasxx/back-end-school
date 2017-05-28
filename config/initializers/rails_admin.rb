RailsAdmin.config do |config|

  ### Popular gems integration

  # == Devise ==
  config.authenticate_with do
    warden.authenticate! scope: :user
  end

  config.current_user_method(&:current_user)

  config.authorize_with do
    redirect_to main_app.root_path unless current_user.admin?
  end
  ## == Cancan ==
  # config.authorize_with :cancan

  ## == Pundit ==
  # config.authorize_with :pundit

  ## == PaperTrail ==
  # config.audit_with :paper_trail, 'User', 'PaperTrail::Version' # PaperTrail >= 3.0.0

  ### More at https://github.com/sferik/rails_admin/wiki/Base-configuration
  config.model 'User' do
    edit do
      exclude_fields :reset_password_sent_at, :remember_created_at, :sign_in_count,
                     :current_sign_in_at, :last_sign_in_at, :current_sign_in_ip,
                     :last_sign_in_ip, :events, :student_grades, :teacher_groups,
                     :groups_teacher, :teacher_lessons, :group_students, :student_lessons,
                     :teacher_grades, :messages, :receipts
    end
  end

  config.actions do
    dashboard                     # mandatory
    index                         # mandatory
    new
    export
    bulk_delete
    show
    edit
    delete
    show_in_app

    ## With an audit adapter, you can add:
    # history_index
    # history_show
  end
end
