class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the passed in user here. For example:
    #
    #   user ||= User.new # guest user (not logged in)
    #   if user.admin?
    #     can :manage, :all
    #   else
    #     can :read, :all
    #   end
    #
    # The first argument to `can` is the action you are giving the user 
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on. 
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details:
    # https://github.com/ryanb/cancan/wiki/Defining-Abilities

    user ||= User.new # guest user (not logged in)
    #if user.admin?
        if (not user.has_role? :admin) && user.id
            can :delete, Publish do |publish|
                    ( publish.user_id == user.id )
            end

            can :delete, Product do |product|
                ( product.publish.user_id == user.id )
            end

            can :manage, User do |target|
                p "target #{target.id}"
                ( target.id == user.id)
            end
        elsif user.has_role? :admin
            can :manage, :all
        else
            can :read, :all
        end
    #end

    #if not user.blank?
    #    can :delete, Publish do |publish|
    #        ( publish.user_id == user.id )
    #    end

    #    can :delete, Product do |product|
    #        ( product.publish.user_id == user.id )
    #    end

    #    can :manage, User do |target|
    #        p "target #{target.id}"
    #        ( target.id == user.id)
    #    end
    #else
    #    cannot :manage, :all 
    #end

  end
end
