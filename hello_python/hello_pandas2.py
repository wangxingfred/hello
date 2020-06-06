import pandas as pd

df = pd.read_csv("uk_rain_2014.csv", header=0)

# print(df)
# print(df.values)
print(df.index)

print(df.head(5))
print(df.tail(5))

print(df.columns)
print(type(df.columns))
df.columns = ['water_year', 'rain_9-10', 'outflow_9-10',
              'rain_12-2', 'outflow_12-2', 'rain_7-8',
              'outflow_7-8']
print(df.columns)
print(df.tail(3))
print("len(df) = ", len(df))

print(df.info())
print(df["rain_9-10"].value_counts())
pd.options.display.float_format = '{:,.3f}'.format
print(df.describe())

print(df['water_year'])
print(df.water_year)

print(df[df["rain_9-10"] < 1000])
print(df[(df["rain_9-10"] < 1000) & (df["outflow_9-10"] < 4000)])
print(df[df.water_year.str.endswith("2")])

print(df.iloc[20])

print(df.set_index(['water_year']).head(2))
print("..............................................................")
print(df.set_index(['water_year']).loc["1980/81"])
print("..............................................................")

print(df.sort_index(ascending=False).head(5))
print("..............................................................")


def base_year(string):
    year_str = string[:4]
    return pd.to_datetime(year_str).year


print(df.head(2))

df['year'] = df.water_year.apply(base_year)

print(df.head(3))
print("..............................................................")
#
# print(df.groupby(df.year // 10 * 10).min())
# print(df.groupby(df.year // 10 * 10).max())
# print(df.groupby(df.year // 10 * 10).mean())
#
# decade_rain = df.groupby([df.year // 10 * 10, df["rain_9-10"] // 1000 * 1000]).mean()
# print(decade_rain)
# print("..............................................................")
#
# print(decade_rain.unstack(0))
# print(decade_rain.unstack(1))
#
# print("..............................................................")
# high_rain = df[df["rain_9-10"] > 1250]
# print(high_rain)
#
# print(high_rain.pivot('year', "rain_9-10").fillna(''))
print("..............................................................")
df_year = df.set_index("year")
print(df_year.head(5))

df_year_rain = df_year[["water_year", "rain_9-10", "rain_12-2", "rain_7-8"]]
df_year_outflow = df_year[["water_year", "outflow_9-10", "outflow_12-2", "outflow_7-8"]]

print(df_year_rain.head(3))
print(df_year_outflow.head(2))
print(df_year_rain.merge(df_year_outflow).head(4))


def noth(number):
    return number


df_year_rain = df_year_rain.reset_index('year')
df_year_outflow = df_year_outflow.reset_index('year')

df_year_rain[["outflow_9-10"]] = df_year_outflow[["outflow_9-10"]]
print(df_year_rain.head(2))

print("........................................................................")
df_year_rain.plot(x='year', y="outflow_9-10")

