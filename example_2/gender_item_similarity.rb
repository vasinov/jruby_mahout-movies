class GenderItemSimilarity
  java_import org.apache.mahout.cf.taste.similarity.ItemSimilarity

  attr_accessor :men, :woman

  def initialize(men, women)
    @men = men
    @woman = woman
  end

  # method from the ItemSimilarity interface
  def itemSimilarity(profile_id_1, profile_id_2)
    profile_id_1_is_man = man?(profile_id_1)
    return 0.0 unless profile_id_1_is_man

    profile_id_2_is_man = man?(profile_id_2)
    return 0.0 unless profile_id_2_is_man

    (profile_id_1_is_man == profile_id_2_is_man) ? 1.0 : -1.0
  end

  # method from the ItemSimilarity interface
  def itemSimilarities(item_id_1, item_id_2s)
    result = []
    item_id_2s.each do |item_id|
      result << itemSimilarity(item_id_1, item_id)
    end

    result
  end

  def man?(profile_id)
    true
  end
end