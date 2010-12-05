package org.harrison.insight.plugin.mongodb;

import java.util.Arrays;
import java.util.List;

import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.Signature;

import com.mongodb.DBCollection;
import com.mongodb.DBObject;
import com.mongodb.MapReduceOutput;
import com.mongodb.WriteResult;
import com.springsource.insight.collection.AbstractOperationCollectionAspect;
import com.springsource.insight.intercept.operation.Operation;

public aspect MongoCollectionOperationCollectionAspect extends
	AbstractOperationCollectionAspect {

    public pointcut insertExecute(): execution(WriteResult DBCollection.insert(..));

    public pointcut updateExecute(): execution(WriteResult DBCollection.update(..));

    public pointcut removeExecute(): execution(WriteResult DBCollection.remove(..));

    public pointcut findExecute(): execution(com.mongodb.DBCursor DBCollection.find(..));

    public pointcut createIndexExecute(): execution(void DBCollection.createIndex(..));

    public pointcut findOneExecute(): execution(DBObject DBCollection.findOne(..));

    public pointcut findAndModifyExecute(): execution(DBObject DBCollection.findAndModify(..));

    public pointcut ensureIndexExecute(): execution(void DBCollection.ensureIndex(..));

    public pointcut dropExecute(): execution(void DBCollection.drop());

    public pointcut getCountExecute(): execution(long DBCollection.getCount(..));

    public pointcut groupExecute(): execution(DBObject DBCollection.group());

    public pointcut distinctExecute(): execution(List DBCollection.distinct(..));

    public pointcut mapReduceExecute(): execution(MapReduceOutput DBCollection.mapReduce(..));

    public pointcut dropIndexExecute(): execution(void DBCollection.dropIndex(..));

    public pointcut collectionPoint():
	insertExecute() && !cflowbelow(insertExecute())
	;

    /*
     * insertExecute() || updateExecute() || removeExecute() || findExecute() ||
     * findOneExecute() || createIndexExecute() || findAndModifyExecute() ||
     * ensureIndexExecute() || dropExecute() || getCountExecute() ||
     * groupExecute() || distinctExecute() || mapReduceExecute() ||
     * dropIndexExecute() ;
     */

    @Override
    protected Operation createOperation(final JoinPoint joinPoint) {
	final Signature signature = joinPoint.getSignature();
	final DBCollection collection = (DBCollection) joinPoint.getThis();

	return new MongoCollectionOperation(getSourceCodeLocation(joinPoint),
		Arrays.asList("one", "two", "three"), signature.getName(),
		signature.toShortString(), collection.getFullName());
	// return new MongoCollectionOperation(getSourceCodeLocation(joinPoint),
	// ArgUtils.toString(joinPoint.getArgs()), signature.getName(),
	// signature.toShortString(), collection.getFullName());
    }
}
