## GETTING R:  Go to "http://cran.stat.ucla.edu" and look for the right 
#			version for your computer.
#
## BASIC R OPERATIONS: Simple operations and lists
#	1. Define a variable and look at it

x <- 12
x

#	2. Mathematical operations on a variable

x+2
x-2
x/2
x*2
x^2

#	3. Saving the result of mathematical operations in another variable

y <- x+2
y

#	3b. Showing the result of an assignment as you do it (sometimes handy
#		for debugging)

(y <- x+2)

#	4. Define a list with the c() function

x <- c(1,2,3,4)
x

#	5. Mathematical operations on a list

x+2
x-2
x/2
x*2
x^2

#	IMPORTANT NOTE - R works on lists, not vectors; you must use special
#		forms of mathematical operations to perform matrix operations
#		correctly.
#
#	5b. Example of R not handling matrix operations correctly

y <- c(1,2,3,4,5,6,7,8)
y

x*x

#	If we mistake lists for vectors (or matrices) then it looks like we
#	just multiplied a 1x4 matrix with a 1x8 matrix.  Take another look at
#	x,y, and the result and see if you can figure out what we really did.
#
#	5c. Example of matrix multiplication

x %*% t(x)
t(x) %*% x
x*x

#	Note: the function t(x) takes the transpose of x
#
#	5d. Matrix function
?matrix
y
z1 <- matrix(y, 2)
z1
z2 <- matrix(y, 2, byrow=TRUE)
z2
z2<-matrix(y,2,4)
z2
z2<-matrix(y,4,2)
z2
?matrix

#	6.  Structure manipulation of lists

# Select a specific element
x
x[1]
x[2]

# Select a range of elements
2:4
x[2:4]
x[c(1,3)]

# Drop a specific element
x[-2]

# Drop a range of elements
x[-(2:3)]

# Use list to select and drop elements
y<-c(1,3)
x[y]
x[-y]

# Combine two lists
x<-c(x,y)
x

z1
z1[1,]
z1[1,2]
z1[,3]



# Reverse a list
rev(x)



#	7. Logical operations
# Test equality
1==5
1==1

# Test inequality
1!=5
1!=1

#	8. Ranges
1:3
seq(from=0, to=1, by=0.12)
seq(from=0, to=1, length=7)
seq(0,1,0.12)
?seq

## USEFUL FUNCTIONS
#	1. Mean, variance, standard deviation
x <- c(1,2,3,4)
mean(x)
var(x)	# NOTE - gives unbiased estimate, not MLE
sd(x)
sd(x)^2

# 	2. Summing a list
sum(x)
prod(x)
?prod


#	3. Length of a list
length(x)

#	4. Densities for various distributions
# d gives f(x), where f() is the density function
dnorm(0, mean=0, sd=1)		# Normal distribution
dexp(1, rate=1)			# Exponential distribution
dbinom(5, size=10, prob=0.5)	# Binomial distribution
dpois(10, lambda=10)		# Poisson distribution
dgamma(1, shape=1, scale=1)	# Gamma distribution

# Here the density function is being evaluated at the given x with the
#	specified parameters
#
# There's several others; look in the help file under "distributions" and
#	scroll down a bit...

help.search("distributions")

# 	5. CDFs, inverse CDFs, and random generation
# I'm just showing the normal distribution, all use the same general form

pnorm(0, mean=0, sd=1)		# P(X<=0)
qnorm(0.95, mean=0, sd=1)# 95% upper tail for normal RV; P(X < qnorm(0.95)) = 0.95, X~N(0,1)
#P(Z<=1.645) = 0.95

set.seed(126621)
rnorm(10, mean=0, sd=1)		# Generates 10 realizations of a normal RV
					# with mean=0 and sd=1

# 	6. Basic plotting
x<-c(1,2,3,4)
y<-x^2
plot(x,y)
lines(x,y)
plot(x,y, xlab="x label here", ylab="y label here",main = "title")

# IMPORTANT: Make sure to always use labels! Otherwise your plots are not
# 	helpful for other people (ie. graders) looking at your plots!

# Data Frames
x<-c(177,166,170,180,160) # height
y<-c(120,102,135,158,95)  # weight
data_01<-data.frame(x,y)
data_01$x
data_01$y
names(data_01) <- c("height", "weight")
data_01$height
data_01


## PROGRAMMING AND FLOW CONTROL
#	1. FOR loops

for(x in 1:10)
{
	print(x+1)
}

#	2. WHILE loops
x<-1
while(x<10)
{
	print(x)
	x<-x+x
}

#	3. Defining functions

Fact <- function(n) if (n == 1) 1 else n * Fact(n - 1) #Recursion
Fact(5)


Square<-function(x){
  xsquare<-x^2
  return(xsquare)
}
Square(5)
