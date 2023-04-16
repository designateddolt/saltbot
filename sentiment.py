from vaderSentiment.vaderSentiment import SentimentIntensityAnalyzer
import json
#note: depending on how you installed (e.g., using source code download versus pip install), you may need to import like this:
#from vaderSentiment import SentimentIntensityAnalyzer

def analyse(message):
    analyzer = SentimentIntensityAnalyzer()
    vs = analyzer.polarity_scores(message)
    print(message)
    return json.dumps(vs)
