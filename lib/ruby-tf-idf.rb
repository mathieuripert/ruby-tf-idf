#!/bin/env ruby
# encoding: ISO-8859-1

require "ruby-tf-idf/version"

module RubyTfIdf

  class TfIdf

    STOP_WORDS_EN = [
      'a','cannot','into','our','thus','about','co','is','ours','to','above',
      'could','it','ourselves','together','across','down','its','out','too',
      'after','during','itself','over','toward','afterwards','each','last','own',
      'towards','again','eg','latter','per','under','against','either','latterly',
      'perhaps','until','all','else','least','rather','up','almost','elsewhere',
      'less','same','upon','alone','enough','ltd','seem','us','along','etc',
      'many','seemed','very','already','even','may','seeming','via','also','ever',
      'me','seems','was','although','every','meanwhile','several','we','always',
      'everyone','might','she','well','among','everything','more','should','were',
      'amongst','everywhere','moreover','since','what','an','except','most','so',
      'whatever','and','few','mostly','some','when','another','first','much',
      'somehow','whence','any','for','must','someone','whenever','anyhow',
      'former','my','something','where','anyone','formerly','myself','sometime',
      'whereafter','anything','from','namely','sometimes','whereas','anywhere',
      'further','neither','somewhere','whereby','are','had','never','still',
      'wherein','around','has','nevertheless','such','whereupon','as','have',
      'next','than','wherever','at','he','no','that','whether','be','hence',
      'nobody','the','whither','became','her','none','their','which','because',
      'here','noone','them','while','become','hereafter','nor','themselves','who',
      'becomes','hereby','not','then','whoever','becoming','herein','nothing',
      'thence','whole','been','hereupon','now','there','whom','before','hers',
      'nowhere','thereafter','whose','beforehand','herself','of','thereby','why',
      'behind','him','off','therefore','will','being','himself','often','therein',
      'with','below','his','on','thereupon','within','beside','how','once',
      'these','without','besides','however','one','they','would','between','i',
      'only','this','yet','beyond','ie','onto','those','you','both','if','or',
      'though','your','but','in','other','through','yours','by','inc','others',
      'throughout','yourself','can','indeed','otherwise','thru','yourselves'
    ]

    STOP_WORDS_FR = [

      '-elle','-il','à','a','afin','ai','ainsi','ais','ait','alors','après','as','assez','au','aucun',
      'aucune','auprès','auquel','auquelles','auquels','auraient','aurais','aurait','aurez',
      'auriez','aurions','aurons','auront','aussi','aussitôt','autre','autres','aux',
      'avaient','avais','avait','avant','avec','avez','aviez','avoir','avons','ayant',
      'beaucoup','c','car','ce','ceci','cela','celle','celles','celui','cependant',
      'certes','ces','cet','cette','ceux','chacun','chacune','chaque','chez','cinq',
      'comme','d','abord','dans','de','dehors','delà','depuis','des','dessous',
      'dessus','deux','deça','dix','doit','donc','dont','du','durant','dès','déjà',
      'elle','elles','en','encore','enfin','entre','er','est','est-ce','et','etc',
      'eu','eurent','eut','faut','fur','hormis','hors','huit','il','ils','j','je',
      'jusqu','l','la','laquelle','le','lequel','les','lesquels','leur','leurs',
      'lors','lorsque','lui','là','m','mais','malgré','me','melle','mes','mm','mme',
      'moi','moins','mon','mr','même','mêmes','n','neuf','ni','non-','nos','notamment',
      'notre','nous','néanmoins','nôtres','on','ont','ou','où','par','parce','parfois',
      'parmi','partout','pas','pendant','peu','peut','peut-être','plus','plutôt','pour',
      'pourquoi','près','puisqu','puisque','qu','quand','quant','quatre','que','quel',
      'quelle','quelles','quelqu','quelque','quelquefois','quelques','quels','qui',
      'quoi','quot','s','sa','sans','se','sept','sera','serai','seraient','serais',
      'serait','seras','serez','seriez','serions','serons','seront','ses','si','sien',
      'siennes','siens','sitôt','six','soi','sommes','son','sont','sous','souvent',
      'suis','sur','t','toi','ton','toujours','tous','tout','toutefois','toutes',
      'troiw','tu','un','une','unes','uns','voici','voilà','vos','votre','vous','vôtres',
      'y','à','ème','étaient','étais','était','étant','étiez','étions','êtes','être',
      'afin','ainsi','alors','après','aucun','aucune','auprès','auquel','aussi','autant',
      'aux','avec','car','ceci','cela','celle','celles','celui','cependant','ces',
      'cet','cette','ceux','chacun','chacune','chaque','chez','comme','comment','dans',
      'des','donc','donné','dont','duquel','dès','déjà','elle','elles','encore','entre',
      'étant','etc','été','eux','furent','grâce','hors','ici','ils','jusqu','les','leur',
      'leurs','lors','lui','mais','malgré','mes','mien','mienne','miennes','miens',
      'moins','moment','mon','même','mêmes','non','nos','notre','notres','nous','notre',
      'oui','par','parce','parmi','plus','pour','près','puis','puisque','quand','quant',
      'que','quel','quelle','quelque','quelquun','quelques','quels','qui','quoi','sans',
      'sauf','selon','ses','sien','sienne','siennes','siens','soi','soit','sont','sous',
      'suis','sur','tandis','tant','tes','tienne','tiennes','tiens','toi','ton','tous',
      'tout','toute','toutes','trop','très','une','vos','votre','vous','étaient','était',
      'étant','être'
    ]

    attr_accessor :tf, :idf, :tf_idf

    def initialize(docs, limit, exclude_stop_words)

      @docs = split_docs(docs)
      @tf = []
      @idf = {}
      @tf_idf = []
      @docs_size = @docs.size
      compute_tf_and_idf
      compute_tf_idf(limit,exclude_stop_words)

    end

    def split_docs(docs)

      splitted_docs = []
      docs.each do |d|
        begin
          splitted_docs << d.downcase!.gsub(/,|\.|\'/,'').split(/\s+/)
        rescue
        end
      end
      splitted_docs
    end


    def compute_tf_and_idf

      @docs.each do |words|

        terms_freq_in_words = words.inject(Hash.new(0)) { |h, e| h[e] += 1 ; h }
        @tf.push(terms_freq_in_words)
        distinct_words = words.uniq
        distinct_words.each do |w|
          if ( @idf.has_key?(w) )
            y = @docs_size / ( 10**(@idf[w]) )
            y += 1
            @idf[w] = Math.log10(@docs_size / y)
          else
            @idf[w] = Math.log10(@docs_size)
          end
        end
      end


      def compute_tf_idf(limit,exlude_stop_words)

        @tf.each do |tf_freq|
          tfidf = Hash.new(0)
          tf_freq.each do |key,value|
            tfidf[key] = @idf[key] * value
          end
          if (exlude_stop_words == true)
            tfidf.reject!{ |k| STOP_WORDS_FR.include?(k) == true }
            tfidf.reject!{ |k| STOP_WORDS_EN.include?(k) == true }
          end
          tfidf = Hash[tfidf.sort_by { |k,v| -v }[0..limit-1]]
          @tf_idf.push(tfidf)
        end
      end

    end
  end

end
