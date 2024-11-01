# Define the destination directory
$chemin = "C:\Users\dylan\OneDrive\Bureau\gen_folder" # Adjust this path accordingly

# Create destination directory if it doesn't exist
if (-not (Test-Path -Path $chemin)) {
    New-Item -Path $chemin -ItemType Directory
    Write-Host "Created directory: $chemin"
}

# Create a table of items
$var = @(
    "plants vocabulary",
    "preposition",
    "ways of Talking",
    "Unreal tenses",
    "Animal verbs",
    "verb tenses",
    "vocabulary",
    "facing the truth",
    "Nouns formed from phrasal verbs",
    "review of past tenses",
    "verb tenses",
    "ways of talking",
    "Be+infinitive",
    "learning Airways",
    "Where is my reservation",
    "could/couldn't",
    "expressing possibility with could/might/may",
    "might have",
    "phrasal Verbs",
    "The future",
    "present simple and present perfect",
    "conditional sentences",
    "present perfect and Past simple",
    "the meeting had started when I arrived",
    "should / shouldn't have",
    "questions tags",
    "Arm and leg idioms",
    "colour expressions",
    "derivation",
    "health vocabulary",
    "welcome aboard",
    "Wish + past simple",
    "Do you like to learn or hate learning",
    "in a meeting",
    "Marketing vocabulary",
    "modal verbs",
    "REview_I liked chocolate ice-cream before",
    "the structure of a company",
    "cultural differences",
    "past perfect",
    "promotion or dismissal",
    "Wait, hope, expect",
    "coming soon",
    "would rather",
    "have something done",
    "orders and request",
    "quotes by the famous",
    "ages",
    "let's arrange our trip to the Netherlands",
    "negative prefixes",
    "Present Perfect Tense - for or Since",
    "they made me do it make and let",
    "present perfect tense yet or already",
    "a day at the market",
    "reflexive pronouns",
    "shall",
    "conditional sentences",
    "deal or no deal",
    "If I were you",
    "so do I...",
    "countable_uncountable nouns",
    "career success by_ing",
    "infinitive_gerund",
    "adjectives",
    "conditional review",
    "passive forms",
    "family",
    "compound adjectives",
    "likely conditions",
    "past simple vs past continuous",
    "they must be happy_must for deduction",
    "idioms",
    "present perfect continuous",
    "through the park_into the station_accross the railways",
    "Can you correct a letter",
    "used to",
    "as like",
    "comparison with as_as",
    "break a leg",
    "confusing vocabulary",
    "comparison and superlatives",
    "GEt",
    "phrasal verb vs verb_preposition",
    "connectors",
    "who_whom_which_that",
    "reported speech",
    "relative clauses",
    "adverbs",
    "make_do_let",
    "going to",
    "irregular verbs",
    "Article",
    "going to vs will",
    "pronouns"
)

# Create directories for each item in the array
foreach ($var_item in $var) {
    $folderPath = Join-Path -Path $chemin -ChildPath $var_item
    if (-not (Test-Path -Path $folderPath)) {
        New-Item -Path $folderPath -ItemType Directory
        Write-Host "Created directory: $folderPath"
    } else {
        Write-Host "Directory already exists: $folderPath"
    }
}
