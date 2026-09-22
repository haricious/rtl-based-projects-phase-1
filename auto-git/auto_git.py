import os
import time
import subprocess
from datetime import datetime

from watchdog.observers import Observer
from watchdog.events import FileSystemEventHandler


REPO_PATH = r"C:\Haricious\RTL Design\rtl-based-projects-phase-1"

GIT_PATH = r"C:\Program Files\Git\cmd\git.exe"


class GitHandler(FileSystemEventHandler):
    def __init__(self):
        super().__init__()
        self.last_run = 0

    def on_any_event(self, event):

        # Ignore folders
        if event.is_directory:
            return

        # Ignore .git folder
        if ".git" in event.src_path:
            return

        # Ignore the auto_git.py file itself
        if os.path.basename(event.src_path) == "auto_git.py":
            return

        # Debounce rapid events
        if time.time() - self.last_run < 10:
            return

        self.last_run = time.time()

        try:
            print("\nChange detected:")
            print(event.src_path)

            # Stage changes
            subprocess.run(
                [GIT_PATH, "add", "."],
                cwd=REPO_PATH,
                check=True
            )

            # Check if there are staged changes
            result = subprocess.run(
                [GIT_PATH, "diff", "--cached", "--quiet"],
                cwd=REPO_PATH
            )

            if result.returncode == 0:
                print("No changes to commit.")
                return

            # Create commit message
            commit_msg = (
                f"Auto commit {datetime.now():%Y-%m-%d %H:%M:%S}"
            )

            # Commit
            subprocess.run(
                [
                    GIT_PATH,
                    "commit",
                    "-m",
                    commit_msg
                ],
                cwd=REPO_PATH,
                check=True
            )

            # Push
            subprocess.run(
                [GIT_PATH, "push"],
                cwd=REPO_PATH,
                check=True
            )

            print("Changes committed and pushed successfully.")

        except subprocess.CalledProcessError as e:
            print("\nGit command failed:")
            print(e)

        except FileNotFoundError:
            print("\nGit executable not found.")
            print("Check the GIT_PATH variable.")

        except Exception as e:
            print("\nUnexpected error:")
            print(e)


if __name__ == "__main__":

    if not os.path.isdir(REPO_PATH):
        print("Repository path not found:")
        print(REPO_PATH)
        exit(1)

    if not os.path.isfile(GIT_PATH):
        print("Git executable not found:")
        print(GIT_PATH)
        exit(1)

    observer = Observer()

    event_handler = GitHandler()

    observer.schedule(
        event_handler,
        REPO_PATH,
        recursive=True
    )

    observer.start()

    print("Watching repository:")
    print(REPO_PATH)
    print("Press Ctrl+C to stop.")

    try:
        while True:
            time.sleep(1)

    except KeyboardInterrupt:
        print("\nStopping watcher...")
        observer.stop()

    observer.join()