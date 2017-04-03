module ContributorsHelper

  def recent_contributor_tags
    @contributor.tags.uniq.last(15).reverse
  end

  def recent_contributor_photos
    @contributor.photos.last(12).reverse
  end

  def all_contributor_tags
    @contributor.tags
  end

end
