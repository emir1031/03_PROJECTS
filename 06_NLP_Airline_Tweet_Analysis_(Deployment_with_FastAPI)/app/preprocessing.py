def cleaning(data):

    import re
    import nltk

    # nltk.download('omw-1.4')  run if you are creating your virtual env frst time

    from nltk import word_tokenize
    from nltk.stem import WordNetLemmatizer
    from nltk.corpus import stopwords 

    nltk.download('wordnet')
    nltk.download('stopwords')
    nltk.download('punkt')
    
    stop_words = stopwords.words('english')
    
    #1. Removing URLS
    data = re.sub(r'http\S+', '', data)

    #2. Removing Tags
    data = re.sub(r'#\w+', '', data)

    #3. Removing Mentions
    data = re.sub(r'@\w+', '', data)

    #4. Contractions Expension & Tokenize
    #text_tokens = word_tokenize(contractions.fix(data.lower())) 
    text_tokens = word_tokenize(data.replace("'", '').lower())

    #5. Removing mentions
    tokens_without_mention = [w for w in text_tokens if not w.startswith('@')]
    
    #6. Remove Puncs
    tokens_without_punc = [w for w in tokens_without_mention if w.isalpha()]
    
    #7. Removing Stopwords
    tokens_without_sw = [t for t in tokens_without_punc if t not in stop_words]
    
    #8. lemma
    text_cleaned = [WordNetLemmatizer().lemmatize(t) for t in tokens_without_sw]
    
    #joining
    return " ".join(text_cleaned)