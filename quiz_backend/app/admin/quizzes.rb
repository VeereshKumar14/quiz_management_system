ActiveAdmin.register Quiz do
    permit_params :title, :description, questions_attributes: [:id, :kind, :prompt, :options, :correct, :_destroy]


    index do
        selectable_column
        id_column
        column :title
        column :description
        column :created_at
        actions
    end

    form do |f|
        f.semantic_errors 
        f.inputs "Quiz details" do
            f.input :title
            f.input :description
        end

        f.inputs "Questions" do
            f.has_many :questions, allow_destroy: true, heading: "Questions", new_record: "Add question" do |q|
                q.input :kind, as: :select, collection: Question::QUESTION_KINDS
                q.input :prompt
                q.input :options, as: :text, hint: 'Enter options as JSON array E.g. ["Option 1", "Option 2"]'
                q.input :correct, as: :text, hint: 'Enter correct answer as JSON array E.g. ["Option 2"]'

            end
        end

        f.actions


    end


end
