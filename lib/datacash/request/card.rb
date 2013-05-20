module Datacash
  module Request
    class Card < Node
      root "Card"

      coerce_key :cv2avs, Cv2Avs
    end
  end
end
