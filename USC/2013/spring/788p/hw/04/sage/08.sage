typeNames = ['totally split', 'ramified', 'inert', 'partially split']

def loadPolys(fileName):
    load(fileName);
    A.<x> = ZZ[];
    return map(lambda poly: A(poly), polys);

#Construct a field from a given polynomial.
def getFieldFromPoly(poly):
    K.<a> = NumberField(poly);
    return K;
    
#Test to see if a prime is ramified.
def is_ramified(factors):
    for fctr in factors:

        if (fctr[1] > 1):
            return true;
    return false;

#Test to see if a prime is split.
def is_partially_split(factors):
    for fctr in factors:
        if (fctr[1] > 1):
            return true;
    return false;

#Wrapper to determine the splitting type of a prime.
def getType(p, K):
    n = K.degree();
    
    #Grab the ring of integers
    O_K = K.maximal_order();
    
    #Factor the prime
    factors = list(factor(O_K.ideal(p)));
    
    if (len(factors) == n):
        return typeNames[0];
        
    if (is_ramified(factors)):
        return typeNames[1];
        
    if (len(factors) == 1):
        return typeNames[2];
        
    return typeNames[3];

#Takes in a prime and a list of fields with an optional bound (X) on the discriminant.
#Computes the splitting type of the prime in each of the fields with bounded discrimnant.
#Note: X defaults to 0, in which case the computation is carried out against all fields.
def computeTypesByPrime(p, fields, X=0):
    types = [];
    for K in fields:
        #Assume fields are sorted ascending by abs(disc(K)).  
        #Check as few as possible.
        if (X > 0 and abs(K.disc()) > X):
            break;
        
        splitType = getType(p, K);
        d = dict();
        d['type'] = splitType;
        d['poly'] = K.polynomial();
        d['prime'] = p;
        types.append(d);
    return types;
    
#Takes in an array of dictionaries (of the type returned by computeTypesByPrime)
#and returns a dictionary representing the counts of each splitting type.
def countTypes(types, X=0):
    #Initialize the dictionary to be returned.
    count = dict();
    for name in typeNames:
        count[name] = 0;
    
    #Count the splitting types    
    for spType in types:
        s = spType['type'];
        count[s] += 1;
    
    return count;

#Count the fields of discriminant bounded above by X in absolute value.
def countFieldsOfBoundedDisc(fields, X):
    #Don't do extra work if the bound is silly.
    if (X <= 0):
        return len(fields);

    count = 0;
    for K in fields:
        if (abs(K.disc()) < X):
            count += 1;
    return count;

#For a given field, count the splitting types for the first X primes.    
def countTypesByField(K, X):
    #Initialize the dictionary
    count = dict();
    for name in typeNames:
        count[name] = 0;
    
    for n in range(1,X + 1):
        p = primes.unrank(n);
            
        splitType = getType(p, K);
        count[splitType] += 1;
    return count;

#Take a dictionary of type counts (such as that returned by countTypes) and return a dictionary of ratios.
#The keys will be the same as the dictionary.
def getRatiosFromCount(count):
    total = reduce(lambda x,y: x + y, count.values());
    retVal = dict();
    for key in count.keys():
        retVal[key] = 0 if total == 0 else simplify(count[key]/total);
    return retVal;

#Find fields where the prime achieves each of the splitting types.
def findFieldsByPrime(fields, p):
    fieldDict = dict();
    
    for K in fields:
        t = getType(p, K);
        if (not t in fieldDict):
            fieldDict[t] = K.polynomial();
            
            #Only grab as many fields as there are splitting types.
            if (len(fieldDict) == len(typeNames)):
                break;
    return fieldDict;

#Construct an array of number fields from an array of field polynomials.
def constructFields(polys):
    fields = map(getFieldFromPoly, polys);
#    for poly in polys:
#        fields.append(getFieldFromPoly(poly));

    #Don't trust the ordering; Sort by abs(disc(K)), increasing.
    fields.sort(lambda K_1,K_2: int(abs(K_1.disc()) - abs(K_2.disc())));
    
    return fields;

#Search the array of fields for one with a square-free discriminant.    
def findFieldOfSqDisc(fields):
    for K in fields:
        if (is_square(K.disc())):
            return K;

#Search the array of fields for one with a square discriminant.
def findFieldOfSqFreeDisc(fields):
    for K in fields:
        if (not is_square(K.disc())):
            return K;

#Load the polynomials from disk.
polys = loadPolys('~/fields.sage');
primes = Primes();

#Construct an array of the fields from the loaded polynomials.
fields = constructFields(polys);

p = primes.unrank(20);
print "Fields where the prime p = " + repr(p) + " achieves each of the splitting types: ";
print findFieldsByPrime(fields, p);
print "\n";

K = findFieldOfSqFreeDisc(fields);
print "Count of splitting types for all primes less than 1000 in the field with square-free discriminant " + repr(K.disc()) + " defined by the polynomial " + repr(K.polynomial()) + ":";
count = countTypesByField(K, 1000);
ratios = getRatiosFromCount(count);
print count;
print ratios;
print "\n";

K = findFieldOfSqDisc(fields);
print "Count of splitting types for all primes less than 1000 in the field with square discriminant " + repr(K.disc()) + " defined by the polynomial " + repr(K.polynomial()) + ":";
count = countTypesByField(K, 1000);
ratios = getRatiosFromCount(count);
print count;
print ratios;
print "\n";

print "Ratios of the count of fileds of discriminant less than 10^n for n = 2, 3, ..., 6:";
f = lambda x: countFieldsOfBoundedDisc(fields, x)/(1/(3*zeta(3).n())*x);
for n in range(2,7):
    print f(10^n);
print "\n";

p = 179;
print "Count of splitting types for p = " + repr(179) + " in fields with disc(K) < 1000: "
count = countTypes(computeTypesByPrime(p, fields,1000));
ratios = getRatiosFromCount(count);
print count;
print ratios;
print "\n";

print map(lambda x: x.n(), ratios.values());
