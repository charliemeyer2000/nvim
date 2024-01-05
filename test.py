#!/Users/charlie/miniconda3/bin/python3
class Test():
    def __init__(self):
        self.array = []

    def add(self, value):
        self.array.append(value)

if __name__ == '__main__':
    test = Test()
    test.add(1)
    print(test.array)
