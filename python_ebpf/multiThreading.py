import threading

## Function to print hello world with threads
def printHelloWorldWithThreadInfo  import threading

## Function to print hello world with threads
def printHelloWorldWithThreadInfo():
    thread_name = threading.current_thread().name
    print(f"Hello, World! from thread {thread_name}")

## Create two threads
thread1 = threading.Thread(target=printHelloWorldWithThreadInfo)
thread2 = threading.Thread(target=printHelloWorldWithThreadInfo)

## Start the threads
thread1.start()
thread2.start()

## Wait for the threads to finish
thread1.join()
thread2.join()