class ApplicationPolicy
  attr_reader :credential, :record

  def initialize(credential, record)
    @credential = credential
    @record = record
  end

  def index?
    false
  end

  def show?
    scope.where(:id => record.id).exists?
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

  def scope
    Pundit.policy_scope!(credential, record.class)
  end

  class Scope
    attr_reader :credential, :scope

    def initialize(credential, scope)
      @credential = credential
      @scope = scope.all
    end

    def resolve
      scope
    end
  end
end
