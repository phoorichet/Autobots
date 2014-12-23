class Metric < ActiveRecord::Base
  belongs_to :service
  belongs_to :visualization

  has_many   :filters,  dependent: :destroy
  has_many   :vspecs,   dependent: :destroy
  has_many   :selectfs, dependent: :destroy

  default_scope order(name: :asc)

  # Get the threshold attribute fro vspecs
  def get_threshold
    d = self.vspecs.select(:value).where(name: 'threshold').first
    return d != nil ? d.value : d
  end

  def get_domain_max
    d = self.vspecs.select(:value).where(name: 'domain_max').first
    return d != nil ? d.value : d
  end

  def get_domain_min
    d = self.vspecs.select(:value).where(name: 'domain_min').first
    return d != nil ? d.value : d
  end
end
