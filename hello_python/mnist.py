from sklearn.datasets import fetch_mldata

mnist = fetch_mldata('MNIST original')
print(mnist)

X, y = mnist["data"], mnist["target"]
print(X.shape)

import matplotlib
import matplotlib.pyplot as plt

some_digit = X[36000]
some_digit_img = some_digit.reshape(28, 28)
plt.imshow(some_digit_img, cmap=matplotlib.cm.binary, interpolation='nearest')
plt.axis("off")
plt.show()


import numpy as np
shuffled_index = np.random.permutation(60000)   # 0 - 59999
X_train, X_test, y_train, y_test = X[shuffled_index], X[60000:], y[shuffled_index], y[60000:]


y_train_5 = (y_train == 5)
y_test_5 = (y_test == 5)

from sklearn.linear_model import SGDClassifier
sgd_clf = SGDClassifier(max_iter=5, random_state=42)
sgd_clf.fit(X_train, y_train_5)


from sklearn.model_selection import cross_val_score
cross_val_score(sgd_clf, X_train, y_train_5, cv=3, scoring='accuracy')


from sklearn.model_selection import cross_val_predict
from sklearn.metrics import confusion_matrix
y_train_pred = cross_val_predict(sgd_clf, X_train, y_train_5, cv=3)
confusion_matrix(y_train_5, y_train_pred)


from sklearn.metrics import precision_score, recall_score, f1_score
precison = precision_score(y_train_5, y_train_pred)
recall = recall_score(y_train_5, y_train_pred)
f1 = f1_score(y_train_5, y_train_pred)
print(precison, recall, f1)


y_scores = sgd_clf.decision_function([some_digit])
threshold = 0
y_some_digit_pred = y_scores > threshold


def plot_precision_recall_vs_threshold(precisions, recalls, thresholds):
    plt.plot(thresholds, precisions, 'b--', label='Precision')
    plt.plot(thresholds, recalls, 'g-', label='Recall')
    plt.legend(loc='center left')
    plt.xlabel('Threshold')


from sklearn.metrics import precision_recall_curve
y_scores = cross_val_predict(sgd_clf, X_train, y_train_5, cv=3, method='decision_function')
precisions, recalls, thresholds = precision_recall_curve(y_train_5, y_scores)
plot_precision_recall_vs_threshold(precisions, recalls, thresholds)


plt.plot(recalls, precisions)
plt.xlabel('Recall')
plt.ylabel('Precision')


y_train_pred_90 = y_scores > 40000
precision = precision_score(y_train_5, y_train_pred_90)
recall = recall_score(y_train_5, y_train_pred_90)
(precision, recall)


from sklearn.metrics import roc_curve
fpr, tpr, thresholds = roc_curve(y_train, y_scores)

def plot_roc_curve(fpr, tpr, thresholds):
    plt.plot(fpr, tpr, 'g-')
    plt.plot([0,1], [0,1], 'k--')
    plt.xlabel('FPR')
    plt.ylabel('TPR')

plot_roc_curve(fpr, tpr, thresholds)