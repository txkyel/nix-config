import { Variable } from "astal";

const time = Variable("").poll(1000, "date +' %H:%M:%S   %d %b, %a'");

const Clock = () => <label label={time()} />;

export default Clock;
