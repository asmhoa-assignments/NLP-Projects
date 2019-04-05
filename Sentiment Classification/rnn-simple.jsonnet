// Starter configuration for CSE 447/547M A2.
// ==========================================

{
  // Pretrained embedding links
  // ==========================
  //
  // * Sections 1 and 2 *
  // Please use the Google News word2vec 300D pretrained embeddings, which
  // are locally accessible from aziak/attu at:
  //     /cse/web/courses/cse447/19wi/assignments/resources/word2vec/GoogleNews-vectors-negative300.txt.gz
  // and remotely at:
  //     https://s3-us-west-2.amazonaws.com/allennlp/datasets/word2vec/GoogleNews-vectors-negative300.txt.gz
  //


  // Stanford Sentiment Treebank configuration
  // =========================================

  "train_data_path": "https://s3-us-west-2.amazonaws.com/allennlp/datasets/sst/train.txt",
  "validation_data_path": "https://s3-us-west-2.amazonaws.com/allennlp/datasets/sst/dev.txt",

  // The test data can be found at:
  // https://s3-us-west-2.amazonaws.com/allennlp/datasets/sst/test.txt

  "dataset_reader": {
    "type": "sst_tokens",
    "use_subtrees": false,
    "granularity": "2-class"
  },
  "model": {
    "type": "sentiment_classifier",
    "text_field_embedder": {
      "token_embedders": {
        "tokens": {
          "type": "embedding",
          "pretrained_file": "/cse/web/courses/cse447/19wi/assignments/resources/word2vec/GoogleNews-vectors-negative300.txt.gz",
          "embedding_dim": 300,
          "trainable": false
        }
      }
    },
    "sentence_encoder": {
      "type": "rnn",
      "bidirectional": false,
      "input_size": 300,
      "hidden_size": 512,
      "num_layers": 1,
    },
    "classifier_feedforward": {
      "input_dim": 512,
      "num_layers": 2,
      "hidden_dims": [512, 2],
      "activations": ["tanh", "linear"],
      "dropout": [0.2, 0]
    }
  },
  "iterator": {
    "type": "bucket",
    "sorting_keys": [["tokens", "num_tokens"]],
    "batch_size": 64
  },
  "trainer": {
    "num_epochs": 40,
    "patience": 10,
    "cuda_device": 0,
    "grad_norm": 2.0,
    "validation_metric": "+accuracy",
    "optimizer": {
      "type": "dense_sparse_adam"
    }
  }
}