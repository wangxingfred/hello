import pandas as pd


'''
    load data
'''
HOUSING_CSV_PATH = "datasets/housing/housing.csv"
def load_housing_data(path):
    return pd.read_csv(path)
housing_df = load_housing_data(HOUSING_CSV_PATH)


'''
    visualize
'''
# import matplotlib.pyplot as plt
# housing_df.hist(bins=50, figsize=(20,20))
# plt.show()


'''
    split train & test
'''
import numpy as np
housing_df["income_cat"] = np.ceil(housing_df["median_income_value"] / 1.5)
housing_df["income_cat"].where(cond = housing_df["income_cat"] < 0.5, other = 0.5, inplace=True)

from sklearn.model_selection import StratifiedShuffleSplit
split = StratifiedShuffleSplit(n_splits=1, test_size=0.2, random_state=42)
for train_indices, test_indices in split.split(X = housing_df, y = housing_df["income_cat"]):
    train_set = housing_df.loc[train_indices]
    test_set = housing_df.loc[test_indices]

housing_train = train_set.drop("median_house_value", axis=1)
housing_test = test_set.drop("median_house_value", axis=1)


'''
    selector for number and text attributes
'''
from sklearn.pipeline import Pipeline
from sklearn.pipeline import FeatureUnion
from sklearn.base import BaseEstimator, TransformerMixin

class DataFrameSelector(BaseEstimator, TransformerMixin):
    def __init__(self, attribute_names):
        self.attributes = attribute_names
    def fit(self, X, y=None):
        return self
    def transform(self, X):
        return X[self.attributes].values

num_attributes = housing_df.drop(labels="ocean_proximity", axis=1)
cat_attributes = ["ocean_proximity"]
num_selector = DataFrameSelector(num_attributes)
cat_selector = DataFrameSelector(cat_attributes)


'''
    imputer for null values
'''
from sklearn.preprocessing import Imputer
num_imputer = Imputer(strategy="median")


'''
    combine attributes adder
'''
class CombineAttrAdder(BaseEstimator, TransformerMixin):
    def __init__(self, add_bedrooms_per_room = True):
        self.add_bedrooms_per_room = add_bedrooms_per_room
    def fit(self, X, y=None):
        return self
    def transform(self, X, y=None):
        X["rooms_per_household"] = X["total_rooms"] / X["households"]
        X["population_per_household"] = X["population"] / X["households"]
        X["bedrooms_per_room"] = X["total_bedrooms"] / X["total_rooms"]
        return X





num_pipe = Pipeline([
    ("selector", num_selector),
    ("imputer", num_imputer),
    ("attr_adder", CombineAttrAdder())
])

cat_pipe = Pipeline([
    ("selector", cat_selector),
    ("onehot", )
])

full_pipe = FeatureUnion(transformer_list=[
    ("num_pipe", num_pipe),
    ("cat_pipe", cat_pipe)
])

full_pipe.fit_transform(housing_train)

