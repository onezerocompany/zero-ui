List<String> tokenize(String string) {
  // remove all non-alphanumeric characters
  var normalizedString = string.replaceAll(RegExp(r'[^a-zA-Z0-9]'), ' ');

  // remove all leading and trailing whitespace
  normalizedString = normalizedString.trim();

  // remove all duplicate whitespace
  normalizedString = normalizedString.replaceAll(RegExp(r'\s+'), ' ');

  // convert to lowercase
  normalizedString = normalizedString.toLowerCase();

  var tokens = normalizedString.split(' ');

  // filter out empty tokens
  tokens = tokens.where((token) => token.isNotEmpty).toList();

  return tokens;
}

/// matches a list of strings against a query
/// returns a score between 0 and 1
/// 0 means no match
/// 1 means a full match
///
///
double scoreObject({
  required List<String> object,
  required String query,
}) {
  double score = 0.0;
  // tokenize the query
  final queryTokens = tokenize(query);

  // tokenize the object
  final objectTokens = tokenize(object.join(' '));

  // if the query or object is empty, return early
  if (queryTokens.isEmpty || objectTokens.isEmpty) {
    return score;
  }

  // loop over the query tokensa
  // if the token matches partially or fully, add to the score
  //
  // if the match is partial, convert the score to a 0 to 1 range
  // based on the length of the token and the length of the match
  //
  // if the match is full, add 1 to the score
  //
  // make sure the total score gets divided by the number of tokens
  // that were matched to get a 0 to 1 range
  for (var queryToken in queryTokens) {
    double tokenScore = 0.0;

    for (var objectToken in objectTokens) {
      if (objectToken.contains(queryToken)) {
        if (objectToken == queryToken) {
          tokenScore += 1;
        } else {
          tokenScore += (queryToken.length / objectToken.length);
        }
      } else if (queryToken.contains(objectToken)) {
        if (objectToken == queryToken) {
          tokenScore += 1;
        } else {
          tokenScore += (objectToken.length / queryToken.length);
        }
      }
    }

    score += tokenScore;
  }

  return score / objectTokens.length;
}
