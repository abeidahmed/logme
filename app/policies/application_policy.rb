class ApplicationPolicy
  attr_reader :user, :record

  def initialize(user, record)
    raise Pundit::NotAuthorizedError, "Sign up or login to continue" unless user

    @user   = user
    @record = record
  end

  def index?
    false
  end

  def show?
    false
  end

  def create?
    false
  end

  def new?
    create?
  end

  def update?
    false
  end

  def edit?
    update?
  end

  def destroy?
    false
  end

  class Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      raise Pundit::NotAuthorizedError, "Sign up or login to continue" unless user

      @user   = user
      @scope  = scope
    end

    def resolve
      scope.all
    end
  end

  def good_headquarter_member?(object: record)
    user.has_membership_of_headquarter?(record) && user.headquarter_invite_accepted?(record)
  end
end
