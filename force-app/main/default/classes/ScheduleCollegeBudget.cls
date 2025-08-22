global class ScheduleCollegeBudget implements Schedulable {
    global void execute(SchedulableContext sc) {
        // Call the batch
        BatchCollegeBudget batch = new BatchCollegeBudget();
        Database.executeBatch(batch, 200); // 200 is the batch size
    }
}