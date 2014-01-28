class CommentPolicy < ApplicationPolicy
        attr_reader :user, :comment


        def update?
                user.author? or user.editor?
        end

        def destroy?
                user.editor?
        end

        def publish?
                user.editor?
        end
        def approve?

                user.editor?
        end

end
