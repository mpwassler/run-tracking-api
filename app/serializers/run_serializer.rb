class RunSerializer < ActiveModel::Serializer
  attributes :type, :geometry, :properties

  def type
    "Feature"
  end

  def geometry
    RGeo::GeoJSON.encode(object.path)
  end

  def properties
    {
      duration: object.duration,
      distance: object.distance,
      title: object.title,
      id: object.id
    }
  end
end