from mrjob.job import MRJob
from mrjob.step import MRStep

#define a class for the job we want to execute
class RatingsBreakdownPerMovie (MRJob):
    
    #define the steps of our job
    def steps(self):
        return [
            MRStep(mapper=self.mapper_get_movies,
                   reducer=self.reducer_count_ratings)
        ]
    
    #define a mapper which will map the movie id's to their ratings. We are returning the movie ID and 1, as the keys and values respectively,
    #since we are interested in counting the number of ratings for movies and not the rating's values themselves.
    def mapper_get_movies(self, _, line):
        (userID, movieID, rating, timestamp) = line.split('\t')
        yield movieID, 1

    #define a reducer which will count all of the ratings for each movie
    def reducer_count_ratings (self, key, values):
        yield key,sum(values)

#run the code above
if __name__ == '__main__':
    RatingsBreakdownPerMovie.run()
