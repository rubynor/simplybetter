module Report
  def self.more_than(num, type, klass)
    klass.constantize.all.select { |k| k.public_send(type).count > num }
  end

  def self.same_as(num, type, klass)
    klass.constantize.all.select { |k| k.public_send(type).count == num }
  end

  module Application
    types = %w(ideas users comments)

    types.each do |type|
      define_singleton_method "with_#{type}" do |num = 1|
        parent::more_than(num, type, 'Application')
      end

      define_singleton_method "without_#{type}" do |num = 0|
        parent::same_as(num, type, 'Application')
      end
    end
  end

  module Customer
    define_singleton_method :with_applications do |num = 1|
      parent::more_than(num, 'applications', 'Customer')
    end

    define_singleton_method :without_applications do |num = 0|
      parent::same_as(num, 'applications', 'Customer')
    end
  end
end
